package kr.co.keycrafter.domain;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int page;
	private int show;
	private int cat;
	@Getter(AccessLevel.NONE)
	private List<String> type;
	@Getter(AccessLevel.NONE)
	private List<String> keyword;

	public Criteria() {
		this(1, 12, 1);
	}
	
	public Criteria(int page, int show, int cat) {
		this.page = page;
		this.show = show;
		this.cat = cat;
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("page", this.page)
				.queryParam("show", this.show)
				.queryParam("cat", this.cat);
		
		if (keyword != null) {
			for (int i = 0; i < keyword.size(); i++) {
				builder.queryParam("type", type.get(i));
				builder.queryParam("keyword", keyword.get(i));
			}
		}
		
		return builder.toUriString();
	}
	/*
	public List<String> getKeywordArr() {
		return keyword == null ? new ArrayList<String>() : keyword;
	}
	*/
	
	public List<String> getKeyword() {
		if (keyword == null) {
			return new ArrayList<String>();
		}
		else {
			return keyword;
		}
	}
	
	public List<String> getType() {
		if (type == null) {
			return new ArrayList<String>();
		}
		else {
			return type;
		}
	}
}
