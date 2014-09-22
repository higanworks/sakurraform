require 'sakurraform/cli/version'
require 'sakurraform/cli/init'
require 'sakurraform/cli/plan'
require 'sakurraform/cli/status'

module SakurraForm
  class CLI < Thor
    desc "plan SUBCOMMAND", ''
    subcommand "plan", SakurraForm::Plan
  end
end
