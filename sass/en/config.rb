# require 'bootstrap-sass'
# Require any additional compass plugins here.

# Change this to :production when ready to deploy the CSS to the live server.
environment = :development
#environment = :production

# In development, we can turn on the FireSass-compatible debug_info.
firesass = false

# Set this to the root of your project when deployed:
#http_path = "/"
css_dir = "src/main/webapp/css/en"
sass_dir = "sass/en/"
#images_dir = "img"
#javascripts_dir = "js"

# You can select your preferred output style here (can be overridden via the command line):
output_style = :expanded or :nested or :compact or :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
line_comments = true


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

sass_options = (environment == :development && firesass == true) ? {:debug_info => true} : {}

class CssSplitter

  def self.split(infile, outdir = File.dirname(infile), max_selectors = 4095)

    raise "infile could not be found" unless File.exists? infile

    rules = IO.read(infile).split(/^}/)
    return if rules.first.nil?

    charset_statement, new_rule_0 = rules.first.partition(/^\@charset[^;]+;/)[1,2]
    rules[0] = new_rule_0 if new_rule_0 > ''
    return if rules.nil?

    # The infile remains the first file
    file_id = 1
    selectors_count = 0
    total_selectors = 0

    # setup first output file
    filename = File.join(outdir, File.basename(infile, File.extname(infile)) + "_#{file_id.to_s.rjust(2, "0")}" + File.extname(infile))
    output = File.new(filename, "w")
    output.write charset_statement
    # end setup of first file

    rules.each do |rule|
      rule_selectors_count = count_selectors_of_rule rule
      # puts rule_selectors_count.to_s
      selectors_count += rule_selectors_count

      # output the rule
      output.write rule + "}" if output

      # Nothing happens until the selectors limit is reached for the first time
      if selectors_count > max_selectors
        # Close current file if there is already one (the first file)
        output.close if output

        # Prepare next file
        file_id += 1
        filename = File.join(outdir, File.basename(infile, File.extname(infile)) + "_#{file_id.to_s.rjust(2, "0")}" + File.extname(infile))
        output = File.new(filename, "w")
        output.write charset_statement

        # add to total selectors
        total_selectors += selectors_count

        # Reset count
        selectors_count = 0
      end
    end

    if total_selectors > max_selectors
      base_fn = File.basename(infile, File.extname(infile))

      output = File.new(infile, "w")
      for i in 1..file_id
        output.write "@import '" + base_fn + "_#{i.to_s.rjust(2, "0")}.css';\n"
      end

      output.close if output
    else
      output.close if output
      File.delete(filename)
    end
  end

  def self.count_selectors(css_file)
    raise "file could not be found" unless File.exists? css_file

    rules = IO.readlines(css_file, '}')
    return if rules.first.nil?

    charset_statement, rules[0] = rules.first.partition(/^\@charset[^;]+;/)[1,2]
    return if rules.first.nil?

    rules.inject(0) {|count, rule| count + count_selectors_of_rule(rule)}.tap do |result|
      puts File.basename(css_file) + " contains #{result} selectors."
    end
  end

  def self.count_selectors_of_rule(rule)
    return rule.partition(/\{/).first.scan(/,/).count.to_i + 1
  end
end

on_stylesheet_saved do |path|
  CssSplitter.split(path) unless path[/\d+$/]
end