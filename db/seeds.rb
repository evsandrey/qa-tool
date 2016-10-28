# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Product.delete_all
Version.delete_all
Build.delete_all
Suite.delete_all
Report.delete_all
InvestigationResult.delete_all

InvestigationResult.create(name: "Application bug", code: "app")
InvestigationResult.create(name: "DB", code: "db")
InvestigationResult.create(name: "Deployment", code: "DPL")

p = Product.create(name: 'Epicor', description: "Seed test")

p.versions.create(name: "v2.300", description: "Seed test")
p.versions.create(name: "v3.400", description: "Seed test")
p.versions.create(name: "v4.500", description: "Seed test")

p.versions.each do |version|
    15.times do |n|
        version.builds.create(name: "bld_#{n}", description: "Seed test")
    end
    
    100.times do |n|
        version.suites.create(name: "suite_name_long_or_not_#{n}", description: "Seed test")
    end
    
    version.builds.each do |build|
       version.suites.each do |suite|
           random_error = ["error 1", "error 2", "error 3", "error 4", "error 5", "error 6"].sample
           random_boolean = [true, false].sample
           build.reports.create(suite_id: suite._id ,result: random_boolean, error: random_error )
       end           
    end
    
end