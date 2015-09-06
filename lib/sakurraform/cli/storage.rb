require 'aws-sdk'
module SakurraForm
  class Storage < Thor
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
      s3 = init_s3

      bucket = s3.buckets[Fog.credentials[:sakura_object_storage_bucket]]
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

    desc 'cat PATH', 'cat object entry'
    def cat(path)
      s3 = init_s3

      bucket = s3.buckets[Fog.credentials[:sakura_object_storage_bucket]]
      obj = bucket.objects.find {|a| a.key == path }
      say(obj.read) if obj
    end

    desc 'delete PATH', 'delete object entry'
    def delete(path)
      s3 = init_s3

      bucket = s3.buckets[Fog.credentials[:sakura_object_storage_bucket]]
      obj = bucket.objects.find {|a| a.key == path }
      if obj
        say("deleting #{obj.key}")
        obj.delete
      else
        say("Object #{path} Not found.")
      end
    end
  end
end
