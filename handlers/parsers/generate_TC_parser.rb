require_rel "../../constants"
require_rel "../tags"
require_rel "../../utils"

class GenerateTCParser
  def self.parse(body)
    data = JSON.parse(body)

    if (!data.nil? && !data.empty?)
      document = parse_template data["template"]
      if (!data["dataset"].nil?)
        clause_dataset = parse_clauses data["dataset"]["clauses"]
        sections_dataset = parse_sections data["dataset"]["sections"] if !data["dataset"]["sections"].nil?
      end
    else
      raise ERRORS[:MISSING_TEMPLATE]
    end

    [document, clause_dataset, sections_dataset]
  end

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
