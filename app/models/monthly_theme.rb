class MonthlyTheme < ApplicationRecord
  has_may :theme_resources, dependent: :destroy
end
