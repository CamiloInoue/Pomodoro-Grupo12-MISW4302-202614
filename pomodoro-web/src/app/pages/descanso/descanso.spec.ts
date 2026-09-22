import { ComponentFixture, TestBed } from '@angular/core/testing';
import { Descanso } from './descanso';

describe('Descanso', () => {
  let component: Descanso;
  let fixture: ComponentFixture<Descanso>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Descanso],
    }).compileComponents();

    fixture = TestBed.createComponent(Descanso);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
