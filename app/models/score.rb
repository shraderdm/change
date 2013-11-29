class Score < ActiveRecord::Base

  scope :best, -> { order(score: :desc).first() }

  def index_of
    results = Score.find_by_sql(['select * from (select *, row_number() over (order by score desc) as rnum from scores order by score desc) as p1 where id = ?;', id])
    results.first.rnum
  end

end
