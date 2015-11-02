# Scraping the recent local obituaries from the Edinburgh Evening News using the scotsman_obituaries gem


## Usage

    so = ScotsmanObituaries.new
    so.search title: 'moredun', date_range: :last_month

Returns an Array of Hash objects, with each Hash object containing the following:

* heading: name of the deceased
* short_text: The name of the person, where they lived, and where they died etc.
* pubdate: date they deid

## Resources

* scotsman_obituaries https://rubygems.org/gems/scotsman_obituaries

scotsman_obituaries gem
