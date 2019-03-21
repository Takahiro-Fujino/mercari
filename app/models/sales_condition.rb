class SalesCondition < ActiveHash::Base
  self.data = [
    { id: 0, name: '出品中' }, { id: 1, name: '取引中' }, { id: 2, name: '売却済' }
  ]
end
