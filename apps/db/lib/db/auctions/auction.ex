defmodule DB.Auctions.Auction do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "auctions" do
    field(:name, :string)
    field(:logo, DB.Uploaders.Image.Type)
    field(:starts_at, :utc_datetime, comment: "开始时间")
    field(:ends_at, :utc_datetime, comment: "结束时间")
    timestamps()
  end


  @doc false
  def changeset(%DB.Auctions.Auction{} = auction, attrs \\ %{}) do
    processed_attrs = attrs |> uniq_filename_attrs

    auction
    |> cast(processed_attrs, [:name, :starts_at, :ends_at])
    |> cast_attachments(processed_attrs, [:logo])
    |> validate_required([:name, :logo, :starts_at, :ends_at])
  end

  def uniq_filename_attrs(%{logo: logo} = attrs)
      when is_map(logo) do
    name =
      :md5
      |> :crypto.hash(logo.path)
      |> Base.encode16()

    logo = %Plug.Upload{logo | filename: "#{name}#{Path.extname(logo.filename)}"}
    %{attrs | logo: logo}
  end

  def uniq_filename_attrs(attrs) do
    attrs
  end
end
