Gem::Specification.new do |s|
  s.name = 'scotsman_obituaries'
  s.version = '0.1.0'
  s.summary = 'A web scraper to scrape the search results from the Scotsman and Edinburgh Evening News obituary annoucements'
  s.authors = ['James Robertson']
  s.files = Dir['lib/scotsman_obituaries.rb']
  s.add_runtime_dependency('nokorexi', '~> 0.3', '>=0.3.1')
  s.signing_key = '../privatekeys/scotsman_obituaries.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/scotsman_obituaries'
end
