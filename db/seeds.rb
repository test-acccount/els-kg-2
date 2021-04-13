# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

DocumentDetail.first_or_create!(
  invoice_contacts: {
    from_company: "M & A Express LLC",
    from_full_name: "Marat Yrysbekov",
    from_address: "467 Carson Dr\nBear Delaware (DE)",
    from_phone: "+1 (571) 294-3347",
    from_country: "United States",
    to_company: "Express Line Services",
    to_full_name: "Bakyt Myrzabekov",
    to_address: "Toktogul str., mp. 'Moto', kab. 24\nBishkek",
    to_phone: "+996 (312) 89-15-95\n+996 (779) 00-88-20\n+996 (553) 47-06-66",
    to_country: "Kyrgyzstan"
  },
  customs_forms_contacts: {
    company: "M & A Express LLC",
    full_name: "Marat Yrysbekov",
    street: "467 Carson Dr",
    city: "Bear",
    state_code: "DE",
    phone: "+1 (571) 294-3347",
    from_country: "United States",
    to_country: "Kyrgyzstan"
  }
)

SiteSetting.first_or_create!(
  data: {
    site_name: "Express Line Services",
    site_name_short: "ELS",
    domain: "els.kg",
    country: "Kyrgyzstan",
    country_code: "KG",
    contact_phone_numbers: "000-0000"
  }
)

SitePricing.first_or_create!(
  data: {
    shipping_local: "630 сом",
    shipping_usd: "$9"
  }
)

ShipmentNextDate.first_or_create!(
  date: Time.zone.now
)
