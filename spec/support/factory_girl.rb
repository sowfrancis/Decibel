RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

# RSpec without Rails
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end

# Test::Unit
class Test::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end

# Cucumber
# env.rb (Rails example location - RAILS_ROOT/features/support/env.rb)
World(FactoryGirl::Syntax::Methods)

# Spinach
class Spinach::FeatureSteps
  include FactoryGirl::Syntax::Methods
end

# Minitest
class Minitest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end

# Minitest::Spec
class Minitest::Spec
  include FactoryGirl::Syntax::Methods
end

# minitest-rails
class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
end