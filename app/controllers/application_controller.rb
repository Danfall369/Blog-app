class ApplicationController < ActionController::Base
    # Agrega el método current_user
    def current_user
      # En este caso, se asume que tienes un modelo llamado User y que este modelo tiene una columna llamada 'id'.
      # Si tienes un sistema de autenticación, aquí es donde deberías buscar al usuario autenticado.
      @current_user ||= User.first
    end
  end
  