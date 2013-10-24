require 'date'

Gem::Specification.new do |s|
  s.name              = %q{refinerycms-imageable}
  s.version           = %q{0.0.1}
  s.description       = %q{Attack Images to different models in Refinery CMS}
  s.date              = Date.today.strftime("%Y-%m-%d")
  s.summary           = %q{Attack Images to different models in Refinery CMS.
                            Inspired by refinerycms-page-images engine.}
  s.email             = %q{nospam.keram@gmail.com}
  s.homepage          = %q{https://github.com/keram/refinerycms-imageable}
  s.authors           = ['Marek Labos']
  s.require_paths     = %w(lib)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

end
