require_rel "../../constants"
require_rel "../tags"
require_rel "../../helper"

class GenerateTCParser
  def self.parse(body)
    data = JSON.parse(body)

    if (!data.nil? && !data.empty?)
      document = parse_template data["template"]
      dataset = parse_dataset(data["dataset"]) if (!data["dataset"].nil?)
    else
      raise ERRORS[:MISSING_TEMPLATE]
    end

    [document, dataset]
  end

  def self.parse_dataset(dataset_body)
    dataset = {}
    dataset[Clause.key] = parse_clauses dataset_body["clauses"]
    dataset[Section.key] = parse_sections dataset_body["sections"] if !dataset_body["sections"].nil?
    dataset
  end

  private

  def self.parse_template(template)
    raise ERRORS[:MISSING_TEMPLATE] if template.nil?
    raise ERRORS[:TEMPLATE_TYPE] if !template.is_a?(String)

    template
  end

  def self.parse_clauses(clauses)
    raise ERRORS[:MISSING_CLAUSES] if clauses.nil?
    raise ERRORS[:CLAUSES_TYPE] if !clauses.is_a?(Array)
    dataset = {}
    clauses.each do |clause|
      dataset[clause["id"]] = Clause.new(clause["id"], clause["text"]) if clause["id"].is_a?(Integer) && !clause["text"].nil?
    end
    dataset
  end

  def self.parse_sections(sections)
    raise ERRORS[:SECTIONS_TYPE] if !sections.is_a?(Array)
    dataset = {}
    sections.each do |section|
      dataset[section["id"]] = Section.new(section["id"], section["clauses_ids"]) if section["id"].is_a?(Integer) && section["clauses_ids"].is_a?(Array)
    end
    dataset
  end
end
