class Post < ActiveRecord::Base
  scope :editables, -> { where(published_at: nil) }
  scope :published, -> { where.not(published_at: nil) }

  def publishable
    Post.find(self.published_id)
  end

  def editable
    Post.find_by(published_id: self.id)
  end

  def editable?
    self.published_at.blank?
  end

  def publishable?
    self.published_at.present?
  end

  def publish
    return false if self.publishable?
    post_attributes = self.attributes.symbolize_keys
    post_attributes.merge!({ published_at: DateTime.now })
    post_attributes.except!(:id, :published_id)
    if self.published_id
      post = self.publishable.update(post_attributes)
    else
      post = Post.create(post_attributes)
    end
    self.published_id = post.id
    self.save
  end


  def unpublish
    if self.editable?
      self.publishable.destroy
      self.published_id = nil
      self.save
    else
      post_editable = self.editable
      post_editable.published_id = nil
      post_editable.save
      self.destroy
    end
  end
end
