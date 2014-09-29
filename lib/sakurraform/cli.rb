require 'sakurraform/cli/version'
require 'sakurraform/cli/init'
require 'sakurraform/cli/plan'
require 'sakurraform/cli/bs'
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
    desc "bs SUBCOMMAND", 'Manage Sakura no Base Storage'
    subcommand "bs", SakurraForm::Bs
  end
end
