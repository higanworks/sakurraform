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


#### sakkuraform status

Show status of resources.

```
$ ./bin/sakkuraform status
  Nework resources
  +----------------+-----------------------------------------------------+--------------+--------------------+-----------------+
  | name           | sakura_name                                         | sakura_id    | subnet             | gateway         |
  +----------------+-----------------------------------------------------+--------------+--------------------+-----------------+
  | defaultrouter  | defaultrouter-d9805cd0-295c-0132-62c1-38e8563c85ec  | 112600778154 | 133.242.242.192/28 | 133.242.242.193 |
  +----------------+-----------------------------------------------------+--------------+--------------------+-----------------+
  | defaultrouter2 | defaultrouter2-e2368190-295c-0132-62c1-38e8563c85ec | 112600778157 | 133.242.242.208/28 | 133.242.242.209 |
  +----------------+-----------------------------------------------------+--------------+--------------------+-----------------+

  Server resources
  +---------+----------------------------------------------+--------------+-----------------+--------+---------------------------+
  | name    | sakura_name                                  | sakura_id    | ipaddress       | status | last_state_changed        |
  +---------+----------------------------------------------+--------------+-----------------+--------+---------------------------+
  | server1 | server1-ed6ea720-295c-0132-62c1-38e8563c85ec | 112600778159 | 133.242.242.194 | up     | 2014-09-29T01:47:57+09:00 |
  +---------+----------------------------------------------+--------------+-----------------+--------+---------------------------+
  | server2 | server2-1f9f9b40-295d-0132-62c1-38e8563c85ec | 112600778162 | 133.242.242.195 | up     | 2014-09-29T01:49:22+09:00 |
  +---------+----------------------------------------------+--------------+-----------------+--------+---------------------------+
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sakurraform/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## LICENSE and Author

LICENSE: MIT

Author: SAWANOBORI Yukihiko(sawanoboriyu@higanworks.com)

