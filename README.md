# Ruby::Clip

A miminal parser for Clip Studio Paint file. Currently this lib can only export
the Canvas previews out of the file.

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

## Usage

``` ruby
require 'clip'

file = Clip::File.open('/path/to/file.clip')
preview = file.previews.first

# Get info about the canvas preview
preview.width    # => 800
preview.height   # => 60000

# Access the preview image content
preview.image    # => "PNG..."

# Save the preview to a file
preview.image_save('/tmp/my_clip_preview.png')

# Save the preview to a temporary file
tempfile = preview.image_tempfile # => #<File:/tmp/ruby-clip--20241211-276516-hunc5h.png>
tempfile.close

# Close the file, coz' you're so well-behaved
file.close
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/flagcatstudio/ruby-clip.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
