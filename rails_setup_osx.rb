$DEBUG = true
$RUBY_VERSION = '2.2.2'
$RAILS_VERSION = '4.2.1'

if ARGV.length == 1
  $RUBY_VERSION = ARGV[0]
end

if ARGV.length == 2
  $RAILS_VERSION = ARGV[1]
end

class Logger
  def self.log(s, typ=0)
    if typ == 0
      puts "-- #{s}"
    elsif typ == 1
      puts "?? #{s}"
    else
      puts "xx #{s}"
    end
  end

  def self.debug_log(s, typ=0)
    Logger.log(s, typ) if $DEBUG
  end
end

class Cmd
  def self.available?(cmd)
    system "which #{cmd} > /dev/null"
  end

  def self.exec_output(cmd)
    system "#{cmd}"
  end

  def self.exec_return(cmd)
    `#{cmd}`
  end

  def self.exec_true(cmd)
    if Cmd.exec_output(cmd) != true
      raise "#{cmd} failed, quitting"
    end
  end
end

# Xcode command line tools are necessary
# Try installing anyway
Logger.debug_log('trying to install Xcode command line tools')
if not Cmd.available?('xocde-select')
  # Oops, no Xcode
  Logger.log('No Xcode installed, please install from App store', 2)
  exit 1
end
Cmd.exec_output('xcode-select --install')


# Check if brew is installed
Logger.debug_log('checking for Homebrew')
if Cmd.available?('brew')
  Logger.debug_log('found Homebrew')
else
  Logger.debug_log('getting brew')
  if not Cmd.exec_output('ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"')
    Logger.log('could not install brew', 2)
    exit 1
  end
end

# Install rbenv
Logger.debug_log('checking for rbenv')
if not Cmd.available?('rbenv')
  # Install rbenv and let user reload the init file
  Logger.debug_log('installing rbenv')
  Cmd.exec_true('brew install rbenv ruby-build')

  # Add to init file
  Cmd.exec_true("echo 'if which rbenv > /dev/null; then eval \"$(rbenv init -)\"; fi' >> ~/.bash_profile")
  Logger.log('[RUN] "source ~/.bash_profile" and restart the setup')
  exit 0
else
  Logger.debug_log('found rbenv')
end

# Install ruby
Logger.debug_log("Installing ruby version #{$RUBY_VERSION}")
Cmd.exec_true("rbenv install #{$RUBY_VERSION}")
Cmd.exec_true("rbenv global #{$RUBY_VERSION}")
Cmd.exec_output('ruby -v')

# Check Git
if not Cmd.available?('git')
  Logger.log('you need to install and configure git', 1)
end

# Install Rails
Logger.log("installing rails version #{$RAILS_VERSION}")
Cmd.exec_true("gem install rails -v #{$RAILS_VERSION}")
Cmd.exec_true('rbenv rehash')
Cmd.exec_output('rails -v')
Cmd.exec_output('which rails')

puts "=Done="




