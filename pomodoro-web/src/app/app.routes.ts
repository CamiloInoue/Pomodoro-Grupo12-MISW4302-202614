import { Routes } from '@angular/router';
//import { EnfoqueActivoComponent } from './pages/enfoque-activo/enfoque-activo.component';
//import { DescansoComponent } from './pages/descanso/descanso.component';
//import { ModalConfirmarComponent } from './pages/modal-confirmar/modal-confirmar.component';
//import { HistorialGeneralComponent } from './pages/historial-general/historial-general.component';
//import { HistorialFiltradoComponent } from './pages/historial-filtrado/historial-filtrado.component';
//import { HistorialDetalleComponent } from './pages/historial-detalle/historial-detalle.component';

export const routes: Routes = [
  { path: '', redirectTo: 'enfoque-activo', pathMatch: 'full' },
  // { path: 'enfoque-activo', component: EnfoqueActivoComponent },
  // { path: 'descanso', component: DescansoComponent },
  // { path: 'modal-confirmar', component: ModalConfirmarComponent },
  // { path: 'historial-general', component: HistorialGeneralComponent },
  // { path: 'historial-filtrado', component: HistorialFiltradoComponent },
  // { path: 'historial-detalle', component: HistorialDetalleComponent }
];