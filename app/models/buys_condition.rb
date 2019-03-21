class BuysCondition < ActiveHash::Base
  self.data = [
    { id: 1, name: '取引中' }, { id: 2, name: '過去の取引' }
  ]
end
