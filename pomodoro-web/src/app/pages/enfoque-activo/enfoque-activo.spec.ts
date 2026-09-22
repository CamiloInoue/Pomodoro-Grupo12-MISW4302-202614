import { ComponentFixture, TestBed } from '@angular/core/testing';
import { EnfoqueActivo } from './enfoque-activo';

describe('EnfoqueActivo', () => {
  let component: EnfoqueActivo;
  let fixture: ComponentFixture<EnfoqueActivo>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [EnfoqueActivo],
    }).compileComponents();

    fixture = TestBed.createComponent(EnfoqueActivo);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
