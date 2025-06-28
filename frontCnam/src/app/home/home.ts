import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-home',
  imports: [FormsModule],
  templateUrl: './home.html',
  styleUrl: './home.css'
})
export class Home {
  login: string = '';
  password: string = '';

  onSubmit() {
    console.log('Login:', this.login);
    console.log('Password:', this.password);
    // Vous pouvez ici appeler un service d'authentification
  }
}
