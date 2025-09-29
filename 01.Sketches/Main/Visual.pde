// ==========================
// CLASE PARA UNA IMAGEN CON FADE
// ==========================
class Visual {
    PImage img;
    int age = 0;
    int lifeTime;

    Visual(PImage _img, int duracion) {
        img = _img;
        lifeTime = duracion;
        float aspectRatio = (float)img.width / img.height;
        // Ajuste para cubrir la pantalla sin distorsión
        if (width / aspectRatio <= height) {
            img.resize(width, (int)(width / aspectRatio));
        } else {
            img.resize((int)(height * aspectRatio), height);
        }
    }

    void update() {
        age++;
    }

    boolean isDead() {
        return age >= lifeTime;
    }

    void display() {
        float alphaIndividual = 255;
        // Fade In (primer 15% del tiempo de vida)
        if (age < lifeTime * 0.15) {
            alphaIndividual = map(age, 0, lifeTime * 0.15, 0, 255);
        // Fade Out (último 20% del tiempo de vida)
        } else if (age > lifeTime * 0.80) {
            alphaIndividual = map(age, lifeTime * 0.80, lifeTime, 255, 0);
        }

        // Combinar el fade individual con el fade global (alphaCurrent)
        float finalAlpha = alphaIndividual * (alphaCurrent / 255.0);

        if (finalAlpha > 0.1) {
            imageMode(CENTER);
            tint(255, finalAlpha);
            image(img, width/2, height/2);
            noTint();
        }
    }
}
