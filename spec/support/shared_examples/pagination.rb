shared_examples "paginated list" do
  it{expect(hash_response).to have_key(:meta)}
  it{expect(hash_response[:meta]).to have_key(:pagination)}
  it{expect(hash_response[:meta][:pagination]).to have_key(:per_page)}
  it{expect(hash_response[:meta][:pagination]).to have_key(:total_pages)}
  it{expect(hash_response[:meta][:pagination]).to have_key(:total_objects)}
end