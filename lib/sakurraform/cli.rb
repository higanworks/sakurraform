require 'sakurraform/cli/version'
require 'sakurraform/cli/plan'


module SakurraForm
  class CLI < Thor
    desc "plan SUBCOMMAND", ''
    subcommand "plan", SakurraForm::Plan
  end
end
