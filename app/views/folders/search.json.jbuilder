json.folders do 
  json.array!(@folders) do |folder|
    json.name folder.name
    json.url folder_path(folder)
  end
end