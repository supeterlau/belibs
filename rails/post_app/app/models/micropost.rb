class Micropost < ApplicationRecord
  # 关联到 user 依赖表中的 user_id
  belongs_to :user
  # 检验 长度<140; 内容不为 空;
  validates :content, length: { maximum: 140 },
    presence: true # 内容不为 空
end
