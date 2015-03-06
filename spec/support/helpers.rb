module PointAddressHelper
  %w(city state country magnitude).each_with_index do |action, idx|
    define_method("point_#{action}") do
      "San Francisco, California, United States, 200".split(',').at(idx)
    end
  end
end

module PointParamHelper
  extend PointAddressHelper
  %w(full without update).each do |action|
    params = { city: point_city,
               state: point_state,
               country: point_country,
               magnitude: point_magnitude
             }
    
    define_method("point_params_#{action}") do |key = nil, val = nil|
      return params if action == 'full'
      return params.except(key) if action == 'without'
      return params.tap { |h| h[key] = val } if action =='update'
    end
  end
end
