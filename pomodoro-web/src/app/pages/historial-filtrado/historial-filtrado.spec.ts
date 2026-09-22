import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HistorialFiltrado } from './historial-filtrado';

describe('HistorialFiltrado', () => {
  let component: HistorialFiltrado;
  let fixture: ComponentFixture<HistorialFiltrado>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HistorialFiltrado],
    }).compileComponents();

    fixture = TestBed.createComponent(HistorialFiltrado);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
