class Product < ActiveRecord::Base
  has_many :line_items

  before_destroy :ensuure_not_referenced_by_any_line_item

  private
    def ensuure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'leave items')
        return false
      end
    end

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with:    %r{\.(gif|jpg|png)$}i,
    message: 'set gif or png or jpg'
  }
end
