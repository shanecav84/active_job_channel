require 'pendant/engine'
require 'pendant/work_as_pendant'

# Top-level namespace
module Pendant
end

ActiveJob::Base.send :extend, Pendant::WorkAsPendant::ClassMethods
