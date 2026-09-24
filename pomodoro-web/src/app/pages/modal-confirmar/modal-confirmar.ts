import { Component } from '@angular/core';
import { RouterModule } from '@angular/router';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-modal-confirmar',
  standalone: true,
  imports: [RouterModule, MatButtonModule],
  templateUrl: './modal-confirmar.html',
  styleUrls: ['./modal-confirmar.css']
})
export class ModalConfirmarComponent {}