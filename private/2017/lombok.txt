title: An Introduction to Project Lombok
created: 2017-08-03
teaser:
  img: lombok.jpg
  author: Nicolas Lannuzel
  url: https://www.flickr.com/photos/nlann/5492110170/
  license:
    name: CC BY SA 2.0
    url: https://creativecommons.org/licenses/by-sa/2.0/
template: post.diego.en.tpl
tags: [ english, java ]


The following map shows the island Lombok's location in south east Asia. You already know its major neighbor in the
west, the one with Indonesia's capital, Jakarta, on it. Right, that's *Java*.

<div class="figure"><img src="/2017/lombok-map.png"><p class="caption">Lombok on a map of Indonesia and Malaysia</p></div>

But this article is not about islands or geography. It's is about [Project Lombok](https://projectlombok.org/),
a plugin to the Java compiler, that allows to automatically generate bytecode for much of the boilerplate that
is required when writing Java code.

Here's a typical Java POJO:

~~~ java
public class Movie {

    private Long id;
    private String title;
    private String subtitle;
    private String genre;
    private String director;
    private LocalDate firstRelease;
    private List<Actor> actors;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public LocalDate getFirstRelease() {
        return firstRelease;
    }

    public void setFirstRelease(LocalDate firstRelease) {
        this.firstRelease = firstRelease;
    }

    public List<Actor> getActors() {
        return actors;
    }

    public void setActors(List<Actor> actors) {
        this.actors = actors;
    }

    public boolean equals(Object object) {
        if (this == object) {
            return true;
        }
        if (object == null || getClass() != object.getClass()) {
            return false;
        }
        if (!super.equals(object)) {
            return false;
        }

        final Movie movie = (Movie) object;

        if (id != null ? !id.equals(movie.id) : movie.id != null) {
            return false;
        }
        if (title != null ? !title.equals(movie.title) : movie.title != null) {
            return false;
        }
        if (genre != null ? !genre.equals(movie.genre) : movie.genre != null) {
            return false;
        }
        if (director != null ? !director.equals(movie.director) : movie.director != null) {
            return false;
        }
        if (firstRelease != null ? !firstRelease.equals(movie.firstRelease) : movie.firstRelease != null) {
            return false;
        }
        if (actors != null ? !actors.equals(movie.actors) : movie.actors != null) {
            return false;
        }

        return true;
    }

    public int hashCode() {
        int result = super.hashCode();
        result = 31 * result + (id != null ? id.hashCode() : 0);
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (subtitle != null ? subtitle.hashCode() : 0);
        result = 31 * result + (genre != null ? genre.hashCode() : 0);
        result = 31 * result + (director != null ? director.hashCode() : 0);
        result = 31 * result + (firstRelease != null ? firstRelease.hashCode() : 0);
        result = 31 * result + (actors != null ? actors.hashCode() : 0);
        return result;
    }

    @Override
    public String toString() {
        return "Movie{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", subtitle='" + subtitle + '\'' +
                ", genre='" + genre + '\'' +
                ", director='" + director + '\'' +
                ", firstRelease=" + firstRelease +
                ", actors=" + actors +
                '}';
    }
}
~~~

That's a hell lot of code (126 LOC, to be exact) for something as simple as a class holding only metadata about movies.

"That's a lot of code, but my IDE can generate it for me," I here you say. That's absolutely correct, but I'd like to
point out that writing boilerplate code is just one side of the coin. A lot of your time you're reading some other
developer's code, hunting for that tricky bug, where the all that boilerplate will obfuscate the essence of the code.

By the way, have you noticed the error/unexpected behavior in the code snippet above?

It's likely you just skimmed through it and thus have missed it. It's in the `equals()` method, where I forgot to check
for equality of `subtitle`. It's included in `hashCode()`, though, so that will likely lead to tricky problems
when keeping a `Set<Movie>`, for example. Errors like these can easily happen when you add a new field to a class, but
forget to re-generate your methods.

In contrast, here's the same class using Lombok, just without the mistake:

~~~ java
@Data
public class Movie {

    private Long id;
    private String title;
    private String subtitle;
    private String genre;
    private String director;
    private LocalDate firstRelease;
    private List<Actor> actors;

}
~~~

Just by annotating the class with `@Data`, Lombok will generate all getters, setters, `equals()`, `hashCode()`,
and even a decent `toString()`. But that's only the tip of the iceberg. There are many other annotations, e.g. for
constructors, the builder pattern, or instantiating a logger. Just have a look at
[the feature list on their website](https://projectlombok.org/features/all) for an overview.

Now that you've seen a code sample, you may worry about
[whether it's safe to use it in your project](https://stackoverflow.com/q/3852091/432354).
Will my IDE still be able to navigate my code? Will it show errors for missing methods? Will I still be able to
refactor using the IDE?

I also wasn't sure until a year ago. But then a colleague of mine just started to use it in one of our products and I
used that as an opportunity to give it a try. I haven't looked back ever since.

Getting started is quite simple. Just add the following dependency:

~~~ xml
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.16.18</version>
    <scope>provided</scope>
</dependency>
~~~

`javac` will automatically detect Lombok on the classpath (Lombok makes use of
[JSR-269: "Pluggable Annotation Processing API"](https://www.jcp.org/en/jsr/detail?id=269)).
The dependency can be _provided_, since there's no need for Lombok to be around at run-time. All the magic happens at
compile-time.

As for IDE support, there's a brilliant Lombok plugin for IntelliJ IDEA. Just search the plugin repository for "lombok".
If you want to use it in Eclipse it's even simpler. Download the lombok.jar from the project website and run it. A
graphical installer will lead you through the required steps.

For instance, here's what the Structure view will look like in IDEA:

<div class="figure"><img src="/2017/lombok-idea.png"><p class="caption">Class <code>Movie</code> in IDEA</p></div>

As you can see, everything from the first code snippet is there.

Of course another way to avoid the tedious work of writing and maintaining Java's boilerplate is using other
JVM languages like Kotlin or Scala, which solve Java's problems using special syntax. But that's a different story.

What do you think about Lombok? Are you also thinking about using it in your software or did you already give it a try?
Let me and others know in the comments.
