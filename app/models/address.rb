class Address < ApplicationRecord
  serialize :address
  belongs_to :user_detail
  before_create :set_slug
  
  private
    def set_slug
      def set_slug
        time =Time.now.localtime
        slug = "ADD#{(rand(10 ** 5)).to_s.rjust(5, '0')}"
        while(Address.exists?(slug: slug))
          slug = "ADD#{(rand(10 ** 5)).to_s.rjust(5, '0')}"
        end
        self.slug = slug
      end
    end
end
