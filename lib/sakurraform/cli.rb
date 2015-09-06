require 'sakurraform/cli/version'
require 'sakurraform/cli/init'
require 'sakurraform/cli/plan'
require 'sakurraform/cli/storage'
require 'sakurraform/cli/status'
require 'sakurraform/cli/map'

module SakurraForm
  class CLI < Thor
    desc "plan SUBCOMMAND", 'Manage plan'
    subcommand "plan", SakurraForm::Plan
  end
end

module SakurraForm
  class CLI < Thor
    desc "storage SUBCOMMAND", 'Manage Sakura no Object Storage (replaced from bs command)'
    subcommand "storage", SakurraForm::Storage
  end
end
