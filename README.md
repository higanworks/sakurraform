# Sakurraform
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/higanworks/sakurraform?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Gem Version](https://badge.fury.io/rb/sakurraform.svg)](http://badge.fury.io/rb/sakurraform)

Manage Infrastructure from Code with Sakura no Cloud and Base Storage.

## TODO

- delete resources.
- update resources if detect diff.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fog'
gem 'sakurraform'
```

And then execute:

    $ bundle

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

Create credential file.

```
$ ./bin/sakurraform init
       exist  .sakuracloud
Sakuracloud_api_token(required) ?  your_api_token
Sakuracloud_api_token_secret(required) ?  your_api_secret
Sakura Base Storage buket name(optional) ?  mybucket
Sakura Base Storage token(optional) ?  mytoken
      create  .sakuracloud/credentials
```

### sakurraform plan SUBCOMMAND 

```
$ ./bin/sakurraform plan
Commands:
  sakurraform plan apply           # Apply plan
  sakurraform plan generate        # Generate template
  sakurraform plan help [COMMAND]  # Describe subcommands or one specific subcommand
```

#### sakurraform plan generate

Create plan template.

#### sakurraform plan apply

Create resources from yaml and save state to file.

```
## Example 2 networks and 2 servers.

$ ./bin/sakurraform plan apply
Create new network defaultrouter
[fog][WARNING] Create Router with public subnet
[fog][WARNING] Waiting available new router...
......      create  state/network/defaultrouter-dbfd50c0-2a2c-0132-62c2-38e8563c85ec.yml
Create new network defaultrouter2
[fog][WARNING] Create Router with public subnet
[fog][WARNING] Waiting available new router...
......      create  state/network/defaultrouter2-e5ea21c0-2a2c-0132-62c2-38e8563c85ec.yml
Create new server server1
[fog][WARNING] Create Server
[fog][WARNING] Create Volume
[fog][WARNING] Waiting disk until available
.[fog][WARNING] Modifing disk
Associate 133.242.242.242 to server1
      create  state/server/server1-efc00f30-2a2c-0132-62c2-38e8563c85ec.yml
Create new server server2
[fog][WARNING] Create Server
[fog][WARNING] Create Volume
[fog][WARNING] Waiting disk until available
.[fog][WARNING] Modifing disk
Associate 133.242.242.243 to server2
      create  state/server/server2-21a3a320-2a2d-0132-62c2-38e8563c85ec.yml
```

create once.

```
$ ./bin/sakurraform plan apply
defaultrouter already available as defaultrouter-dbfd50c0-2a2c-0132-62c2-38e8563c85ec
defaultrouter2 already available as defaultrouter2-e5ea21c0-2a2c-0132-62c2-38e8563c85ec
server1 already available as server1-efc00f30-2a2c-0132-62c2-38e8563c85ec
server2 already available as server2-21a3a320-2a2d-0132-62c2-38e8563c85ec
```

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

open map page by browser...


### sakurraform bs SUBCOMMAND 


```
$ ./bin/sakurraform bs
Commands:
  sakurraform bs cat PATH        # cat object entry
  sakurraform bs create          # Create bucket(..just open browser)
  sakurraform bs delete PATH     # delete object entry
  sakurraform bs help [COMMAND]  # Describe subcommands or one specific subcommand
  sakurraform bs ls              # list object entries
```

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

#### sakurraform bs cat

```
$ ./bin/sakurraform bs cat 20140930_debug.out_0
{"hoge":"mogemoge","piyo":"piyo"}
```

#### sakurraform bs delete

```
$ ./bin/sakurraform bs delete 20140930_debug.out_0
deleting 20140930_debug.out_0
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

