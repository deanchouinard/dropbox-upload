Mix.install([
  :req,
  :multipart,
  :tzdata,
  :httpoison
])

IO.puts "Starting..."
current_datetime = DateTime.utc_now()
IO.puts("Current Date and Time: #{current_datetime}")
{:ok, local_datetime} = DateTime.shift_zone(current_datetime, "America/New_York", Tzdata.TimeZoneDatabase)
IO.puts("Current Local Date and Time: #{local_datetime}")

# Extracting year, month, and day
year = DateTime.to_date(local_datetime).year
month = DateTime.to_date(local_datetime).month
day = DateTime.to_date(local_datetime).day

# Extracting time
{hour, minute, second} = {local_datetime.hour, local_datetime.minute, local_datetime.second}

IO.puts("Year: #{year}, Month: #{month}, Day: #{day}")
IO.puts("Time: #{hour}:#{minute}:#{second}")


IO.inspect(strAppId = System.get_env("APP_ID"), label: "strAppId")
strSecretKey = System.get_env("SECRET_KEY")
strRefreshToken = System.get_env("REFRESH_TOKEN")

filename = "#{year}-#{month}-#{day}_#{hour}#{minute}#{second}_test.txt"
IO.puts filename
file_contents = "test"
File.write(filename, file_contents)
File.close(filename)

sAPP_KEY = "1cj3bm85iel52nm"
sAccessCode = "bHLA4MPU0rgAAAAAAAB9vL4CUU3qg1_AffstQWSewUk"

Req.get!("https://hex.pm/api/packages/req").body["meta"]["description"]
|> IO.inspect()

# Req.get!("https://www.dropbox.com/oauth2/authorize?client_id=#{sAPP_KEY}&token_access_type=offline&response_type=code").body
#|> IO.inspect()

{:ok, resp} = Req.post("https://api.dropbox.com/oauth2/token", [auth:
  {:basic, "#{strAppId}:#{strSecretKey}"}, form: [grant_type:
  "refresh_token", refresh_token: "#{strRefreshToken}"]])

IO.inspect resp.body
IO.puts resp.body["access_token"]
strAccessToken = resp.body["access_token"]

# curl -X POST https://content.dropboxapi.com/2/files/upload \
#     --header "Authorization: Bearer $KEY" \
#     --header "Dropbox-API-Arg: {\"path\": \"/bu/$filename\"}" \
#     --header "Content-Type: application/octet-stream" \
#     --data-binary @"$1"
#

model = "test"
multipart =
      Multipart.new()
      |> Multipart.add_part(
        Multipart.Part.file_content_field(filename, file_contents, :file, filename: filename)
      )

content_length = Multipart.content_length(multipart)
content_type = Multipart.content_type(multipart, "multipart/form-data")

key = "test"
headers = [ {"Authorization", "Bearer #{strAccessToken}"},
  {"Dropbox-API-Arg", "{\"path\": \"/bu/#{filename}\"}"},
#  {"Content-Type", content_type},
#  {"Content-Length", to_string(content_length)}
  {"Content-Type", "application/octet-stream"}
]


# {:ok, resp} = Req.post("https://content.dropboxapi.com/2/files/upload",
#   headers: headers,
#   body: Multipart.body_stream(multipart)
#   )
#


{:ok, resp} = HTTPoison.post("https://content.dropboxapi.com/2/files/upload",
  {:file, filename},
  headers)


IO.inspect resp.body


