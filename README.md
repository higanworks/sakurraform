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
$ ./bin/sakurraform 
Commands:
  sakurraform bs SUBCOMMAND    # Manage Sakura no Base Storage
  sakurraform help [COMMAND]   # Describe available commands or one specific command
  sakurraform init             # initiaize .sakuracloud/credentials
  sakurraform map              # open sakura cloud map!
  sakurraform plan SUBCOMMAND  # Manage plan
  sakurraform status           # show status
  sakurraform version          # show version

```

### sakurraform init

Create credential file

### sakurraform plan SUBCOMMAND 

#### sakurraform plan generate

Create plan template.

#### sakurraform plan apply

Create resources from yaml.


#### sakurraform status

Show status of resources.

```
$ ./bin/sakurraform status
  Nework resources
  +----------------+-----------------------------------------------------+--------------+--------------------+-----------------+
  | name           | sakurraform_name                                    | sakura_id    | subnet             | gateway         |
  +----------------+-----------------------------------------------------+--------------+--------------------+-----------------+
  | defaultrouter  | defaultrouter-d9805cd0-295c-0132-62c1-38e8563c85ec  | 112600778154 | 133.242.242.192/28 | 133.242.242.193 |
  +----------------+-----------------------------------------------------+--------------+--------------------+-----------------+
  | defaultrouter2 | defaultrouter2-e2368190-295c-0132-62c1-38e8563c85ec | 112600778157 | 133.242.242.208/28 | 133.242.242.209 |
  +----------------+-----------------------------------------------------+--------------+--------------------+-----------------+

  Server resources
  +---------+----------------------------------------------+--------------+-----------------+--------+---------------------------+
  | name    | sakurraform_name                             | sakura_id    | ipaddress       | status | last_state_changed        |
  +---------+----------------------------------------------+--------------+-----------------+--------+---------------------------+
  | server1 | server1-ed6ea720-295c-0132-62c1-38e8563c85ec | 112600778159 | 133.242.242.194 | up     | 2014-09-29T01:47:57+09:00 |
  +---------+----------------------------------------------+--------------+-----------------+--------+---------------------------+
  | server2 | server2-1f9f9b40-295d-0132-62c1-38e8563c85ec | 112600778162 | 133.242.242.195 | up     | 2014-09-29T01:49:22+09:00 |
  +---------+----------------------------------------------+--------------+-----------------+--------+---------------------------+

```

### sakurraform map

open map page by bwowser...


### sakurraform bs SUBCOMMAND 

#### sakurraform bs create

Create bucket(..just open browser)

#### sakurraform bs ls

list object entries.

```
$ ./bin/sakurraform bs ls
  +----------+----------------+---------------------+---------------------------+-------------------------------------------------------+
  | key      | content_length | content_type        | last_modified             | public_url                                            |
  +----------+----------------+---------------------+---------------------------+-------------------------------------------------------+
  | hogehoge | 0              | binary/octet-stream | 2014-09-30 02:14:27 +0900 | http://test-hogehgoe.b.storage.sakura.ad.jp/hogehoge |
  +----------+----------------+---------------------+---------------------------+-------------------------------------------------------+
  | mogemoge | 0              | binary/octet-stream | 2014-09-30 02:14:28 +0900 | http://test-hogehoge.b.storage.sakura.ad.jp/mogemoge |
  +----------+----------------+---------------------+---------------------------+-------------------------------------------------------+
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

