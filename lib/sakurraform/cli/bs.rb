require 'aws-sdk'
module SakurraForm
  class Bs < Thor
    include Thor::Actions
    include SakurraForm::Helper

    def self.source_root
      File.expand_path("../../", __FILE__)
    end

    desc 'create', 'Create bucket(..just open browser)'
    def create
      system('open https://secure.sakura.ad.jp/storage/#!/namespace/manage/')
    end

    desc 'ls', 'list object entries'
    def ls
      s3 = AWS::S3.new(
        :access_key_id => Fog.credentials[:sakura_base_storage_bucket],
        :secret_access_key => Fog.credentials[:sakura_base_storage_token] ,
        :s3_endpoint => 'b.storage.sakura.ad.jp',
        :use_ssl => false
      )

      bucket = s3.buckets[Fog.credentials[:sakura_base_storage_bucket]]
      table = bucket.objects.entries.map do |ent|
        {
          :key => ent.key,
          :content_type => ent.content_type,
          :content_length => ent.content_length,
          :last_modified => ent.last_modified,
          :public_url => ent.public_url.to_s
        }
      end
      Formatador.display_table(table, [:key, :content_length, :content_type, :last_modified, :public_url])
    end
  end
end
