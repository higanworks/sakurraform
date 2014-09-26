# Sakurraform

[WIP]

Manage Infrastructure from Code with Sakura no Cloud

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sakurraform'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sakurraform

## Usage

```
$ ./bin/sakkuraform 
Commands:
  sakkuraform help [COMMAND]   # Describe available commands or one specific command
  sakkuraform init             # initiaize .sakuracloud/credentials
  sakkuraform plan SUBCOMMAND  # 
  sakkuraform status           # show status
  sakkuraform version          # show version
```

### sakurraform init

Create credential file

### sakkuraform plan SUBCOMMAND 

#### sakkuraform plan generate

Create plan template.

#### sakkuraform plan apply

Create resources from yaml.


## Contributing

1. Fork it ( https://github.com/[my-github-username]/sakurraform/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## LICENSE and Author

LICENSE: MIT

Author: SAWANOBORI Yukihiko(sawanoboriyu@higanworks.com)

