# Intro
This research is aimed to cover only `Rack::Lock` usage across variety of Ruby web servers in production mode. It doesn't intended to be benchmark report.

## WEBrick
**WEBrick** results with and without `Rack::Lock` are almost the same:

```
53.01 real   0.36 user   0.15 sys
Count: 250
```

Because there is only `one` serving process and `one` thread.

## Puma

#### **Puma** with `2 x workers` and `2 x threads` without `Rack::Lock`
```
21.47 real   0.41 user   0.21 sys
Count: 75
Count: 75
```
There **is** race condition: `75 + 75 = 150`

#### **Puma** with `2 x workers` and `2 x threads` with `Rack::Lock`
```
34.50 real   0.41 user   0.22 sys
Count: 132
Count: 118
```
There is no race condition: `132 + 118 = 250`

#### **Puma** with `4 x workers` and `1 x threads` without `Rack::Lock`
```
25.72 real   0.35 user   0.18 sys
Count: 70
Count: 62
Count: 51
Count: 67
```
There is no race condition: `70 + 62 + 51 + 67 = 250`

#### **Puma** `4 x workers` and `1 x threads` with Rack::Lock
```
25.85 real   0.39 user   0.20 sys
Count: 63
Count: 63
Count: 58
Count: 66
```
There is no race condition: `63 + 63 + 58 + 66 = 250`

## Unicorn
Started as `env RAILS_ENV=production unicorn -p 9091 -c config/unicorn.rb`.

#### **Unicorn** `4 x workers` without Rack::Lock
```
21.27 real   0.38 user   0.20 sys
Count: 58
Count: 69
Count: 65
Count: 58
```
There is no race condition: `58 + 69 + 65 + 58 = 250`

#### **Unicorn** `4 x workers` with Rack::Lock
```
21.29 real         0.38 user         0.19 sys
Count: 65
Count: 63
Count: 60
Count: 62
```
There is no race condition: `65 + 63 + 60 + 62 = 250`

There is no time difference which expected from `Rack::Lock`.

## Notes

This how `Rack::Lock` may be controlled in `application.rb`:
```
config.allow_concurrency = false
```
It's always possible to check if `Rack::Lock` still in middleware stack:
```
env RAILS_ENV=production bundle exec rake middleware
```

## TODO:
- Try to rum `puma` on non-MRI Rubies
- ~~`Thin` server~~
