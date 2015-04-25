module WildflyCliAssembler
  def assemble_address(resource)
    address = []

    resource.split('/').each do |token|
      values = token.split('=')
      if !values.empty?
        address << { values[0] => values[1] }
      end
    end

    address
  end

  def assemble_command(command)
    path, operation = command.split(':')

    command = {
      :address => assemble_address(path)
    }

    command.merge assemble_operation(operation)
  end

  def assemble_operation(operation)
    dummy, operation, another_dummy, attribute = /([\w\-]+)\(([\w\-]+)=(.+)\)/.match(operation).to_a

    { :operation => operation, :name => attribute }
  end
end