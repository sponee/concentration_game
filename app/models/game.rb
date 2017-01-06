class Game < ApplicationRecord
  belongs_to :user
  has_many :cards
  after_create :generate_cards, :set_score, :set_current_player
  
  validates :user_id, presence: true
  validates :player_one_id, presence: true
  validates :player_two_id, presence: true
  validate :validate_player_uniqueness

  scope :active, -> { where(winner_id: nil) }
  scope :completed, -> { where.not(winner_id: nil)}
  
  def update_current_player
    if self.current_player_id == player_one_id
      self.update_attributes(current_player_id: player_two_id)
    elsif self.current_player_id == player_two_id
      self.update_attributes(current_player_id: player_one_id)
    end
  end

  def update_score(current_player_id)
    if self.current_player_id == self.player_one_id
      self.player_one_score += 1
      self.save
    elsif self.current_player_id == self.player_two_id
      self.player_two_score += 1
      self.save
    end
  end

  def end_game
    if self.cards.matched.count >= 10
      if player_one_score > player_two_score
        self.winner_id = player_one_id
      else
        self.winner_id = player_two_id
      end
    self.save
    end
  end

  private

  def validate_player_uniqueness
    errors.add(:base, "Games must have different Players") if player_one_id == player_two_id
  end

  def generate_cards
    (Card::CARDS*2).shuffle.each_with_index do |card, index|
      self.cards.create(content: card.content, image_url: card.image_url, position: index)
    end
  end

  def set_score
    self.update_attributes(player_one_score: 0, player_two_score: 0)
  end

  def set_current_player
    update_attributes(current_player_id: player_one_id)
  end
end
