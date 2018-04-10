class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  # GET /members.json
  def index
    @members = Member.all
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::StaleObjectError
    render plain: '競合エラーが発生しました。'
    # 競合エラー発生時のSQL
    # begin transaction
    # UPDATE "members" 
    # SET 
    #   "name" = '小林未奈', 
    #   "updated_at" = '2018-04-10 06:05:25.497660', 
    #   "lock_version" = 2 
    # WHERE 
    #   "members"."id" = ? 
    #   AND "members"."lock_version" = ?  
    # [["id", 1], 
    # ["lock_version", 1]]
    # commit transaction

    # begin transaction
    # UPDATE "members" 
    # SET 
    #   "name" = 'こばやし未奈', 
    #   "lock_version" = 2, 
    #   "updated_at" = '2018-04-10 06:05:35.310184' 
    # WHERE 
    #   "members"."id" = ? 
    #   AND "members"."lock_version" = ?  
    # [["id", 1], 
    # 　["lock_version", 1]]
    # rollback transaction
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :email, :lock_version)
    end
end
