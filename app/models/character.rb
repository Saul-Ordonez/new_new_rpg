class Character < ApplicationRecord
  has_many :items, as: :imageable

  scope :by_user_id, -> (user_id) do
    where("user_id = #{user_id}")
  end

  def damage_enemy(enemy_id)
    if self.battled.include? ",#{enemy_id}:"
      enemy_array = self.battled.split(',')
      current_hp = enemy_array.select { |e| e.start_with?("#{enemy_id}:") }
      .first.split(':')[1].to_i
      current_hp -= self.damage
      current_hp = (current_hp > 0) ? current_hp : 0
      self.battled = enemy_array.map { |e|
        (e.start_with?("#{enemy_id}:")) ? "#{enemy_id}:#{current_hp}" : e
      }.join(',')
    else
      enemy = Enemy.find(enemy_id)
      current_hp = enemy.hp
      current_hp -= self.damage
      current_hp = (current_hp > 0) ? current_hp : 0
      self.battled += ",#{enemy_id}:#{current_hp}"
    end
    self.get_wrecked(enemy_id)
    self.save
  end

  def item_grab(item_id)
    if !self.picked_up.include?(",#{item_id},")
      self.picked_up += ",#{item_id},"
      item = Item.find(item_id)
      if item.effect == 'hp'
        self.hp += item.value
      else
        self.damage += item.value
      end
      self.save
    end
  end

  def get_enemy_hp(enemy_id)
    if self.battled.include? ",#{enemy_id}:"
      self.battled.split(',').select { |e| e.start_with?("#{enemy_id}:") }
      .first.split(':')[1].to_i
    else
      nil
    end
  end

  def get_wrecked(enemy_id)
    self.hp -= Enemy.find(enemy_id).damage
  end
end
