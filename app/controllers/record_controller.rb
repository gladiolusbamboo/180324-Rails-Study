class RecordController < ApplicationController
  def find
    @cds = Cd.find([2,5,10])
    # ↓発行されるSQL
    # SELECT "cds".* 
    # FROM "cds"
    # WHERE "cds"."id"
    # IN (2, 5, 10)
    render 'yahoo/list'
  end

  def find_by
    @cd = Cd.find_by(label: 'サザナミレーベル')
    # ↓発行されるSQL
    # SELECT  "cds".* FROM "cds" 
    # WHERE "cds"."label" = ? 
    # LIMIT ?  
    # [["label", "サザナミレーベル"], 
    # ["LIMIT", 1]]

    # find_byは１県のみ取得する

    render 'yahoo/show'
  end
end
