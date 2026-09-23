import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-descanso',
  standalone: true,
  imports: [RouterModule, MatButtonModule],
  templateUrl: './descanso.html',
  styleUrls: ['./descanso.css']
})
export class DescansoComponent {}