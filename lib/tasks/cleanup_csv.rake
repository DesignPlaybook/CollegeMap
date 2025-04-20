namespace :cleanup do
    desc "Delete CSV files older than 1 day in public/csvs"
    task old_csvs: :environment do
        csv_dir = Rails.root.join("public", "csvs")
        cutoff_time = 1.day.ago

        Dir.glob("#{csv_dir}/*.csv").each do |file|
            if File.mtime(file) < cutoff_time
                File.delete(file)
                puts "Deleted old CSV: #{file}"
            end
        end
    end
end
  