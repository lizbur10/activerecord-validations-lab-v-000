class TitleValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        unless !!value && (value.include?("Won't Believe") || value.include?("Secret") || value.include?("/([Tt]op)\s\d+/") || value.include?("Guess"))
            record.errors[attribute] << (options[:message] || "is not clickbait-y enough")
        end
    end
end

class Post < ActiveRecord::Base
    validates :title, presence: true, title: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
end
