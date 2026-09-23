import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { MatButtonModule } from '@angular/material/button';
import { MatProgressBarModule } from '@angular/material/progress-bar';

@Component({
  selector: 'app-enfoque-activo',
  standalone: true,
  imports: [RouterModule, MatButtonModule, MatProgressBarModule],
  templateUrl: './enfoque-activo.html',
  styleUrls: ['./enfoque-activo.css']
})
export class EnfoqueActivoComponent {}