defmodule DB.Auctions.AuctionItem do
  use Ecto.Schema
  import Ecto.Changeset
  alias DB.Product
  alias DB.Auctions.{AuctionItem, Auction}

  schema "auction_items" do
    field :current_price, :decimal, comment: "当前报价"
    field :commission_rate, :decimal, comment: "佣金比例 %"
    field :commission_amount, :decimal, comment: "佣金金额"
    field :margin, :decimal, comment: "利润"
    field :start_price, :decimal, comment: "起拍价格"
    field :starts_at, :utc_datetime, comment: "起拍时间"
    field :ends_at, :utc_datetime, comment: "结束时间"
    field :seq_no, :integer, comment: "拍品顺序"
    field :state, :string, comment: "状态"
    field :item_logo, DB.Uploaders.Image.Type, comment: "图标"
    field :description, :string, comment: "描述"
    field :title, :string, comment: "拍品名称"
    field :specification, :string, comment: "规格说明"
    field :grade, :string, comment: "拍品等级" 

    belongs_to :auction, Auction

    timestamps()
  end

  @doc false
  def changeset(%AuctionItem{} = auction_item, attrs) do
    auction_item
    |> cast(attrs, [:start_price, :starts_at, :ends_at, :current_price, :margin,
      :commission_rate, :commission_amount, :state, :item_logo, :title,
      :description, :specification, :grade, :auction_id])
    |> validate_required([:start_price, :starts_at, :current_price, :margin,
      :commission_rate, :commission_amount, :title, :description])
  end
end
